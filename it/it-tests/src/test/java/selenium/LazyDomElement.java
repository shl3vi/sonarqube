package selenium;

import com.google.common.base.Function;
import com.google.common.base.Predicate;
import com.google.common.base.Supplier;
import com.google.common.collect.FluentIterable;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.Select;

import javax.annotation.Nullable;
import java.util.Collection;
import java.util.List;
import java.util.NoSuchElementException;

class LazyDomElement {
  private final SeleniumDriver driver;
  private final By selector;
  private final ElementFilter filter;
  private final Retry retry;

  LazyDomElement(SeleniumDriver driver, By selector) {
    this(driver, selector, Retry._30_SECONDS);
  }

  LazyDomElement(SeleniumDriver driver, By selector, Retry retry) {
    this(driver, selector, ElementFilter.any(), retry);
  }

  private LazyDomElement(SeleniumDriver driver, By selector, ElementFilter filter, Retry retry) {
    this.driver = driver;
    this.selector = selector;
    this.filter = filter;
    this.retry = retry;
  }

  public LazyDomElement withText(final String text) {
    String fullDescription = " with text [" + text + "]";

    return with(new ElementFilter(fullDescription, new Function<Collection<WebElement>, Collection<WebElement>>() {
      @Override
      public Collection<WebElement> apply(Collection<WebElement> stream) {
        return FluentIterable.from(stream).filter(new Predicate<WebElement>() {
          @Override
          public boolean apply(@Nullable WebElement element) {
//            return Objects.equals(element.getText(), text);
            return element.getText().contains(text);
          }
        }).toList();
      }
    }));
  }

  public LazyShould should() {
    return new LazyShould(this, Retry._5_SECONDS, true);
  }

  public void fill(final CharSequence text) {
    execute("fill(" + text + ")", new Consumer<WebElement>() {
      @Override
      public void accept(WebElement element) {
        element.clear();
        element.sendKeys(text);
      }
    });
  }

  public void select(final String text) {
    executeSelect("select(" + text + ")", new Consumer<Select>() {
      @Override
      public void accept(Select select) {
        select.selectByVisibleText(text);
      }
    });
  }

  public void executeSelect(String description, final Consumer<Select> selectOnElement) {
    execute(description, new Consumer<WebElement>() {
      @Override
      public void accept(WebElement element) {
        selectOnElement.accept(new Select(element));
      }
    });
  }

  public void click() {
    execute("click", new Consumer<WebElement>() {
      @Override
      public void accept(WebElement element) {
        element.click();
      }
    });
  }

  public void check() {
    execute("check", new Consumer<WebElement>() {
      @Override
      public void accept(WebElement element) {
        if (!element.isSelected()) {
          element.click();
        }
      }
    });
  }

  public void execute(Consumer<WebElement> action) {
    execute("execute(" + action + ")", action);
  }

  private LazyDomElement with(ElementFilter filter) {
    return new LazyDomElement(driver, selector, this.filter.and(filter), retry);
  }

  private void execute(String message, Consumer<WebElement> action) {
    System.out.println(" - " + Text.toString(selector) + filter.getDescription() + "." + message);

    Supplier<Optional<WebElement>> findOne = new Supplier<Optional<WebElement>>() {
      @Override
      public Optional<WebElement> get() {
        List<WebElement> elements = stream();
        if (elements.isEmpty()) {
          return Optional.empty();
        }
        return Optional.of(elements.get(0));
      }
    };

    try {
      retry.execute(findOne, action);
    } catch (NoSuchElementException e) {
      throw new AssertionError("Element not found: " + Text.toString(selector));
    }
  }

  List<WebElement> stream() {
    return FluentIterable.from(filter.getFilter().apply(driver.findElements(selector))).toList();
  }

  @Override
  public String toString() {
    return Text.toString(selector) + filter.getDescription();
  }
}