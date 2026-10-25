# eCommerce Test Automation – Robot Framework

![UI Tests](https://github.com/YOUR-GITHUB-USERNAME/ecommerce-test-automation/actions/workflows/ui-tests.yml/badge.svg)

Automated UI tests for the core customer journey of a web shop: **login → browse products → cart → checkout**.
Built with **Robot Framework** and the **Browser library** (Playwright), run automatically in a **GitHub Actions** CI pipeline.

The system under test is [Sauce Demo](https://www.saucedemo.com), a public practice web shop.

## What is covered

| Area | Tests | Type |
|---|---|---|
| Login | Valid login; locked-out user, wrong password, missing username/password (data-driven) | smoke, regression |
| Products | Sort by price (low→high), sort by name (Z→A), product detail page | smoke, regression |
| Cart | Add items and check badge and cart contents; remove from cart; badge disappears when empty | smoke, regression |
| Checkout | Full end-to-end order; required-field validation for first name, last name and postal code (data-driven) | smoke, regression, e2e |

10 test cases, 16 scenarios including data-driven rows.

## Design choices

- **Page object pattern.** Locators and actions for each page live in `resources/pages/`, so a UI change is fixed in one place and tests read like business steps.
- **Test data separated from tests.** `variables/test_data.py` holds users, products and customer data.
- **Data-driven negative tests.** Robot Framework templates cover several invalid inputs with one keyword.
- **Isolated tests.** One browser per suite and a fresh browser context per test, so cart and session state never leak between tests.
- **Tags** (`smoke`, `regression`, `e2e`) allow running a quick smoke set or the full regression set.
- **Evidence on failure.** A screenshot is captured automatically when a step fails.
- **CI pipeline.** Runs on every push and pull request, plus a weekly scheduled run to catch changes in the site. The HTML report is published as a build artifact.

## Project structure

```
├── .github/workflows/ui-tests.yml   # CI pipeline
├── resources/
│   ├── common.resource              # setup/teardown, shared settings
│   └── pages/                       # page objects
│       ├── login_page.resource
│       ├── inventory_page.resource
│       ├── cart_page.resource
│       └── checkout_page.resource
├── tests/
│   ├── 01_login.robot
│   ├── 02_products.robot
│   ├── 03_cart.robot
│   └── 04_checkout.robot
├── variables/test_data.py           # test data
└── requirements.txt
```

## Run locally

Requires Python 3.10+ and Node.js 18+.

```bash
pip install -r requirements.txt
rfbrowser init chromium

robot --outputdir results tests                              # all tests, headless
robot --outputdir results --variable HEADLESS:False tests    # watch the browser
robot --outputdir results --include smoke tests              # smoke tests only
```

Open `results/report.html` to see the results.

## CI report

Every pipeline run uploads the Robot Framework report. Open the **Actions** tab, choose a run and download **robot-report**.

## Possible next steps

- API tests for the same flows (RequestsLibrary)
- Cross-browser runs (Firefox, WebKit) as a CI matrix
- Parallel execution with Pabot
- Mirror the pipeline in Azure DevOps

## Author

Chippy Pillai – QA Test Lead, Vaasa, Finland · [chippypillai.github.io](https://chippypillai.github.io)
