# Shiny App Development List

In this file, I detail the shiny apps I have developed for teaching. They are loosely organized by statistical topic, and each app has a description of the app as well as notes for how to improve it.

## ANOVA apps


### `compare-sample-means-same-pop`:

**Description:**

* Displays comparative box plots and strip charts for three samples *taken from the same population*.
* The user can adjust the sample size, and use a button to grab a new set of three samples.

**Purpose:** The goal is to demonstrate, especially on low sample sizes, that three samples can look quite different from one another even though we are sampling from a single distribution. In other words, a visual check is not sufficient for deciding if three samples come from different populations.

**Revisions:**

* We could possibly toggle on/off a $P$-value for an ANOVA test using the three sample means
* Should we allow the user to change all three means? This gives the option of setting up either a situation where the means are equal, or a situation where at least one mean is different.
* Provide better annotation for using the app, potentially a welcome page?


### `f-distr-choose-means`:

**Description:** Plots an $F$-distribution (red line) based on the chosen sample size and the assumption that all three population means are equal.  Then, based on the sample mean sliders, it simulates a sampling distribution of $F$-statistics based on drawing from the actual populations. The user can see whether the simulation matches the assumed probability distributions.

* The user can control the population means for each of the three populations, as well as the size of the sample drawn from each population.
* The user can toggle between a histogram or a density plot for the simulated sampling distribution.

**Purpose:** The goal is for students to realize the actual $F$ sampling distribution differs significantly from the null $F$-distribution when the population means are not the same.  Moreover, sample size *does* affect this!  One can then talk about how when means are different, the blue part (actual sampling distribution) implies we are more likely to get an $F$-statistic considered "rare" by the metric of the null distribution (red line).

**Revisions:**

* We could incorporate this as a tab in the previous app
* Perhaps highlight the region where we would reject the null hypothesis?
* Nicer looking annotation?
* Allow checkbox toggling of null distribution
* Random sample button that generates observed $F$-statistics overlayed on the plot.

### `f-stat-compare-choose-means`:

**Description:** View a comparative strip chart, as well as varation between and within groups and the F-statistic based on three samples from three populations.

* The user can control the sample size, as well as the population means of the three populations from which we sample.

**Purpose:** The goal is to have the user explore how sample size, and differeing population means, affect some of the statistical summaries used in ANOVA analysis. Specifically, we look at mean squared errors between groups, mean squared errors within groups, and the ratio resulting in the $F$-statistic.

**Revisions:**

* As mentioned above, this could be a tab in one big app developed for ANOVA ideas.
* Could incorporate a tracing effect, where as we add new samples we keep a log (via a histogram) of the $F$-statistics generated.  Then give an option to toggle the actual null $F$-distribution.


### Reflections

* Perhaps think of a way to combine all three of these apps into a single app, serving the necessary use-cases
    * All three could have the user set the sample means
    * The last two apps could be combined into one perhaps. Consider a pane with the visual and the three statistics. As we add samples (include a 'get 50 samples' button) we generate the observed-actual distribution of $F$-statistics. Then we can toggle the null $F$-distribution.
    * With the larger app, we need to annotate the app better.



***

## Confidence intervals apps

### `ci-mean-choose-me`: 

**Description:** 
The user can control 

* the sample size
* the margin of error.  

From there, using either get one sample or get 50 samples, one creates a record of confidence intervals based on samples form the population. The success rate is reported.

**Purpose:** The goal is to have the usre understand the effects of sample size and margin of error on the "success rate" of the confidence interval process.  Then one can discuss finding the "just right" choice of margin of error that yields a high success rate with the smallest chosen value of ME.

**Revisions:**

* NA

### `ci-mean-t-interval`:

**Description:** From a population, we draw random samples and compute a record of confidence intervals based on a $t$-distribution margin of error. User can control the `sample size` of the samples, and collect samples one at a time or 50 at a time.  The confidence interval is toggled on and off, and a record of the success rate is displayed.

**Purpose:** The goal is to show that even on low sample sizes (when taken from a normal distribution), the $t$-interval for a mean does relatively well in terms of succes rates.

**Revisions:**

* Potentially add an option to sample from a non-normal distribution to see the $t$-distribution breaking down on small samples with non-normal distributions.
* Should/could be combined with `ci-mean-wald-sigma` and `ci-mean-wald-sigma-unknown` below as part of a tab-based exploration of given confidence intervals.


### `ci-mean-wald-sigma`:

**Description:** From a population, we draw random samples and compute a record of confidence intervals based on a $z$-distribution margin of error, ***knowing $\sigma$**. User can control the `sample size` of the samples, and collect samples one at a time or 50 at a time.  The confidence interval is toggled on and off, and a record of the success rate is displayed.

**Purpose:** Just to demonstrate that this process can be streamlined, and that when we know $\sigma$ (population standard deviation) the success rate does not suffer from small sample sizes.

**Revisions:**

* Make this part of the `ci-mean-...` series.

### `ci-mean-wald-sigma-unknown`:

**Description:** From a population, we draw random samples and compute a record of confidence intervals based on a $z$-distribution margin of error, ***without knowing $\sigma$** and using the sample standard deviation instead. User can control the `sample size` of the samples, and collect samples one at a time or 50 at a time.  The confidence interval is toggled on and off, and a record of the success rate is displayed.

**Purpose:** To demonstrate that using the sample standard deviation instead of $\sigma$ leads to a lower than expected success rate if we continue to use the normal distribution to get our critical values.

**Revisions:**

* Make this part of the `ci-mean-...` series.


### `ci-perc-agresti-coull`:

**Description:** Shows samples taken from a population and creates a record of confidence intervals for population percentage computed from the samples based on the Agresti-Coull method. The user can control the population percentage and sample size, and they can toggle the confidence interval on and off.  A success rate is displayed below, as the user gets either one sample or a collection of 50 samples using a button.

**Purpose:** The goal is to show that the Agresti-Coull method, as opposed to the wald approach, has a better success rate when $np$ or $n(1-p)$ is small (i.e. under 5). 

**Revisions:**

* Perhaps display $np$ and $n(1-p)$ to reinforce the conditions underwhich the wald interval does not do as well.
* Could/should be paired with `ci-perc-wald` below as a joint app using tabs.



### `ci-perc-choose-me`:

**Description:** Shows samples taken from a population and creates a record of confidence intervals for population percentage computed from the samples based on a margin of error *chosen by the user*. In addition to this chosen margin of error, the user can control the population percentage and sample size, and they can toggle the confidence interval on and off.  A success rate is displayed below, as the user gets either one sample or a collection of 50 samples using a button.

**Purpose:** The goal is to allow the user to explore how a chosen margin of error, population percentage, and samples size all interact to influence the success rate of the confidence interval process. 

**Revisions:**

* None for now?



### `ci-perc-wald`:

**Description:** Shows samples taken from a population and creates a record of confidence intervals for population percentage computed from the samples based on the Wald method. The user can control the population percentage and sample size, and they can toggle the confidence interval on and off.  A success rate is displayed below, as the user gets either one sample or a collection of 50 samples using a button.

**Purpose:** The goal is to show that the Wald method does not achieve the desired success rate when $np$ or $n(1-p)$ is small (i.e. under 5).  

**Revisions:**

* Perhaps display $np$ and $n(1-p)$ to reinforce the conditions underwhich the wald interval does not do as well.
* Combine with the previous app, `ci-perc-agresti-coull`.



### `ci-samp-distr-demo`:

**Description:** A sampling distribution for a sample mean appears, and a button allows the user to select a new sample that is then plotted along the $x$-axis.  Now 95\% of the time, the sample mean will fall in the blue region. 

* Toggling the CI visual, one can see the margin of error is the same length as the half the blue region
* As one gets samples, one can see that if the sample mean is in the blue region, the confidence interval will overlap the actual population mean.
* Only when a sample is in the red-tail region will the CI miss the population mean


**Purpose:** The goal is have the user understand how the sampling distribution plays a role in choosing a margin of error that leads to a particular success rate for a confidence interval.

**Revisions:**

* Better annotation?
* Turn the plot sideways and show a population sample visual as well?


### Reflections

* How do we rescale axes without getting a warning message that axes already exist?
* Combine via tabs the ci generators for wald and t intervals, as well as wald and agresti-coull.
    * Annotate these new combined ci-generators to highly the low sample size problems that the wald interval typically encounters, and how t-intervals and agresti-coull try to circumvent that, but at the cost of larger margins of error.
    * *allow an option for a non-normal population so that $t$-interval doesn't do well?*
* Adjust the colors of the `ci-perc-*` files to be consistent.





***

## Descriptive statistics apps

### `chebyshevs`:

**Description:** Drop down menu allows the user to select from different "shaped" populations, and then one can toggle the 2 standard deviation from the mean region.  The percentage of the population in the 2-sd-region gets reported, reinforcing that Chevyshev's inequality is

1. A very weak bound (often more than 75\% is in the region, but certainly at least that much)
2. Applies to many different population distributions.

**Purpose:** Explore and reinforce Chebyshev's inequality for several different population distributions.

**Revisions:**

* Perhaps combine this with the `empirical-rule` app below.



### `empirical-rule`:

**Description:** The user can adjust the mean and standard deviation for a normal population.  With a checkbox, the user can toggle the 2-standard-deviation-from-mean region and see the percentage of the population that falls in that region.

**Purpose:** The goal is to demonstrate how the empirical rule, and the 2-sd-region, naturally adjust to capture "most" of the data when the population distribution is normal. Also, with the normal shape, the user can see how the 95\% estimate is accurate and consistent.

**Revisions:**

* Not sure, perhaps combine this with the `chebyshevs` app. 



### `measures-center`:

**Description:** There are three tabs for the user to explore

* **Outliers**: A data set with a uniform distribution is provided, and the user is given the ability to add outliers and see how this affects the histogram, as well as descriptive statistics (mean, median, std dev, and IQR).
* **Multi-modal**: This looks at the union of two normal distributions, where the user can control the means to make them different or equal. The user can naturally create a bimodal distribution to see that the mean and median, in such cases, are not "near" the data in the way one might expect from a uni-modal distribution.
* **Skewed data**: We present a histogram of data, with a slider to control the skew of the data. One can hit the "play button" to have the plot move from a negative skew toward a positive skew. The user can look at how the mean, median, or both, react to these changes in skew.

**Purpose:** This app provides some visual demonstrations of the limitations of measures of center, specifically the median and mean. By exploring, one sees that the mean is sensitive to outliers, both measures can be misleading in the presecence of multi-modal data, and the relative position of the mean to the median can give an indication of skew.

**Revisions:**

* Better annotate each tab. Some have a field with instructions, but nothing is mentioned there!




### Reflections

* Possibly combine `chebyshevs` and `empirical-rule` into one app summarizing rules for the "2-sd-region".
* The `measures-center` needs more annotation and instructions.



***

## Apps under Development

### `template`:

**Description:**

* D

**Purpose:** The goal is 

**Revisions:**

* We could 





## Hypothesis testing apps

### `actual-null-samp-distr-compare-means`:

**Description:** This is a two tab visualization:

* On the first tab, the user can choose the population mean of the "null" population. The visual updates to show a comparison of the null population against the actual population.
* On the second tab, the user sees a copy of the null population, and using buttons (get 1 or get 100) and a slider to change the sample size, the user can generate a null sampling distribution. Lastly, the user can toggle the actual sampling distribution to compare the two for overlap.

**Purpose:** The goals are to:

* reinforce the approach of comparing a null sampling distribution against the actual sampling distribution, create a conversation point to talk about how our samples come from the actual population and so are influenced by the actual sampling distribution.
* The user can see that when we correctly guess the actual population mean, the two sampling distributions are about the same, meaning our actual sample will likely fall in the middle of the generated null sampling distribution.
* The user can see that when we incorrectly guess the actual population mean, the two sampling distributions are separated, meaning our actual sample will likely fall **away from** the middle of the generated null sampling distribution.
* The user can use sliders to explore how sample size and effect size (difference between the actual pop mean and null pop mean) affect the comparative sampling distributions.

**Revisions:**

* Allow user to toggle a density plot instead of histogram when comparing the *actual sampling distribution* to the null sampling distribution.
* Add a histogram to the side of the population scatter plots?
* Can adjust plot limits so that we don't have removed points from the geometry
* Adjust axis labels 

### `actual-null-samp-distr-compare-perc`:

**Description:** This is a two tab visualization:

* On the first tab, the user can choose the population percentage of the "null" population. The visual updates to show a comparison of the null population against the actual population.
* On the second tab, the user sees a copy of the null population, and using buttons (get 1 or get 100) and a slider to change the sample size, the user can generate a null sampling distribution for the population percentage. Lastly, the user can toggle the actual sampling distribution to compare the two for overlap.

**Purpose:** The goals are to:

* reinforce the approach of comparing a null sampling distribution against the actual sampling distribution, create a conversation point to talk about how our samples come from the actual population and so are influenced by the actual sampling distribution.
* The user can see that when we correctly guess the actual population percentage, the two sampling distributions are about the same, meaning our actual sample will likely fall in the middle of the generated null sampling distribution.
* The user can see that when we incorrectly guess the actual population percentage, the two sampling distributions are separated, meaning our actual sample will likely fall **away from** the middle of the generated null sampling distribution.
* The user can use sliders to explore how sample size and effect size (difference between the actual pop percentage and null pop percentage) affect the comparative sampling distributions.


**Revisions:**

* Adjust colors in comparing the two sampling distributions (null versus actual)
* Allow user to toggle a density plot instead of histogram when comparing the *actual sampling distribution* to the null sampling distribution.
* Adjust sampling distribution plot so we are not missing bars? (This could be a y-axis or x-axis thing)
* Adjust axis labels 



### `compare-two-sample-means-same-pop`:

**Description:** The user can choose a sample size, and then use the visualization (box plot and strip plot with means) to compare two sample means coming from populations *with the same mean population mean*.  

**Purpose:** The goal is show students that when sample sizes are small, there is a significant amount of variation in sample means, which can lead us into mistakenly thinking that population means are different, when they are in fact the same (Type I error). When sample sizes increase, this variation also decreases (hence so does our Type I error possibility).

**Revisions:**

* We should add sliders allowing us to choose the population means, but get the same visualization. This could allow us to talk about Type II errors.
* Combine this with the `two-sample-means-table` app via tabs, allowing us to explore via a visualization or a table. (Probably too much to put all on one page?)
* Adjust plot limits to avoide box plot and strip plot errors.



### `ht-process-tabs`:

**Description:** This is a four tab visualization

* Tab 1: the user can set a null hypothesis type (less, greater, equal), a null hypothesis value (slider), and a sample size. From these inputs, a null sampling distribution gets generated. The user can now use a button to select a single sample to proceed through the other steps.
* Tab 2: show's the "scale and shift" step, where the data and our actual collected sample mean gets transformed into $t$-distribution units (formula provided). We display a new histogram of $t$-values, and overlay the appropriate $t$-distribution model based on the sample size.
* Tab 3: Simple step, we take the previous visual and show a copy of it with the $t$-values histogram removed, so just the $t$-distribution and test statistic remain. We also shade in the direction of the alternative hypothesis and share the $P$-value.
* Tab 4: We show the $P$-value picture again, and compare the outputs to the `t.test()` command in R.

**Purpose:** The goal is highlight the steps of a simple hypothesis test to better reveal the role that probability distributions play, the meaning of a $P$-value, and how the formula for the test statistic is actually used.
  
**Revisions:**

* This code could be a lot cleaner using helper functions.
* Can we make the slider for null mean and drop down for null type appear before above the tabs? This would allow us to make changes at the end to explore new hypothesis and effect on $P$-value
* Axis labels are garbage


### `two-sample-means-table`:

**Description:** The user can set the population means of two different populations. The visual displays these populations as histograms so that we can see the amount of overlap between them.  The user then selects a sample size, and can use the "sample" button to collect a random sample from each population.  The app generates a table reporting each sample mean, as well as the difference in means (pop 2 minus pop 1). 

**Purpose:** The goal is to allow the user to explore how the difference in sample means behaves when two populations have either the same mean, or different means. One can also explore how sample size affects the consistency of a positive/negative/near-zero difference of means under different situations.

**Revisions:**

* We should combine this with `compare-two-sample-means-same-pop` to explore visually and through a table.  Use tabs.





## Statistical power apps

### `p-vals-distribution`:

**Description:** By setting a null hypothesis mean, we can explore the distribution of $P$-values.  The app is designed to sample from a population with a mean of 100, so 

* setting null mu = 100 looks at the distribution of $P$-values when the null hypothesis is true (i.e, $P$-values left of our red line indicates a Type I Error).
* setting null mu equal to something other than 100 looks at the distribution of $P$-values when the null hypothesis is false (i.e, $P$-values *right* of our red line indicates a Type II Error).

The user can also change the sample size and population standard deviation.

**Purpose:** The goals are for students to

* understand that $P$-values are randomly determined by the sample we collect
* have a better understanding of Type I and II errors
* explore how sample size, effect size (via changing null mu), and population standard deviation affect the Type I and Type II errors of a simple hypothesis test.

**Revisions:**

* We could add a slider for $\alpha$, the significance level.
* Perhaps would be better as a three tab app:
    * Type I errors: where null $\mu$ is fixed at 100. Add some annotation/directions
    * Type II errors: where we use a slider for the *difference between actual and null means*, emphasizing effect size.  Add annotation/directions.
    * General Explore: where we have this general app, with the addtional $\alpha$ slider.


### `power`:

**Description:** The user controls the *difference in means* for two populations, as well as sample size and significance level. The app plots the two population as density plots, as well as the simulated sampling distributions based on the sample size. For the sampling distributions, we highlight with bright green the region of our *actual sampling distribution* where we would reject the null hypothesis (based on $\alpha$). We also report the power given the set-up created by the sliders.

**Purpose:** The goals are for user to visualize the power of a test. Specificially, the user can explore visually ***how*** effect size, sample size, and significance level change the power of the test. For example, changing the sample size (all others the same) reduces the variation in the sampling distributions causing them to separate, which creates more power.

**Revisions:**

* Make it clearer that the actual population has a mean of 95.
* Fix the axes so we can see the effect of sample size better, or have user put in the x-axis scale? 
* Move annotation outside of the sidebar



## Probability distributions apps

### `binom-distribution`:

**Description:** The user can select $n$ (sample size) and $p$ (probability of individual success), and the app creates a bar plot of the Binomial Distribution PMF.  The "mean" and "standard deviation" of this probability distribution are reported, and there is an option to toggle and highlight the 2-$\sigma$ region.

**Purpose:** The goal is to allow the user to explore the effect of the parameters $n$ and $p$ on the shape and values of the PMF.

**Revisions:**

* Possible add a "show sample data" example and allow the user to also play with $n$ and $p$ to "fit" the sample data?
    * Would the sample size here be fixed?


### `chisq-distribution`:

**Description:** The user can control $d$, the degrees of freedom for the chi-squared distribution. The user can toggle on a histogram of sample data and attempt to find a good $d$-value where the distribution follows the data.

**Purpose:** The goal is to have the student explore how $d$ affects the shape of the chi-squared distribution.  It also gives an informal sense of how a probability distribution might be "fit" to data by choosing a $d$-value that seems to follow the peaks of the histogram.

**Revisions:**

* More explanation and annotation.


### `f-distribution`:

**Description:** The user can control the fixed sample size for the groups, as well as the number of groups, and the corresponding $F$-distribution is plotted.

**Purpose:** The goal is to show how the $F$-distribution responds to changing these experimental choices (how many to include in each group, and how many groups you're studying).  

**Revisions:**

* A better connection to the two different "degrees of freedom" parameters for the $F$-distribution.
* Model some data? Maybe not appropriate.


### `norm-distr-explore`:

**Description:**  The user can control the mean ($\mu$) and standard deviation ($\sigma$) for a normal distribution, and the density of the random variable appears.  One can toggle some sample data, and use the parameters to "fit" the data.


**Purpose:** The goal is to make the user familiar with how $\mu$ and $\sigma$ effect the normal probability distribution.  The user can also gain some informal understanding of how a probability distribution can be "fit" to sample data.

**Revisions:**

* ?


### `t-distr-histogram-to-density`:

**Description:** As the user selects the mean of the population and the sample size one plans to get from the population, a sampling distribution of sample means is generated via simulation.  The user can toggle this to display as a histogram, or a density plot.  Then, to show the connection to the $t$-distribution, one can overlay the appropriately scaled $t$-distribution over the data.


**Purpose:** The goal is to convince the user that the $t$-distribution is an optimal probability distribution to model sample means taken from a normal population when we don't know the population standard deviation.

**Revisions:**

* Incorporate a normal distribution sketch to see that it doesn't quite "fit" when sample sizes are small?
* 


### `t-vs-norm-compare`:

**Description:** The user can change the sample size, and compare the $t$-distribution against the standard normal distribution.

**Purpose:** The goal is to demonstrate that when $n>30$, the $t$ and standard normal distributions are nearly the same. However, on smaller sample sizes, the $t$-distribution has "fatter tails". This is how the $t$-based confidene intervals account for the uncertainty in using $s$ rather that $\sigma$ in the margin of error formula. The $t$-interval leads to wider confidence intervals on smaller sample sizes, hence keeping the success rate high.

**Revisions:**

* ?







## Linear regression apps


### `normality-hist-qq`:

**Description:** This demonstration allows the user to explore how histograms and QQ-plots look for differen "shapes" of distributions (normla, positive skew, negative skew, uniform, and bimodal). The user can explore how there is a consistent shape in the histogram and definite pattern in the qq-plot when sample sizes are high, but when sample sizes are low things get rather tricky.

* D

**Purpose:** The goal is have the user become more comfortable "diagnosing" with histograms and qq-plots, when getting a sense of whether a data set (specifically residuals) are normal.  They should realize that this is tricky, and borderline arbitrary, when the sample sizes are small, unless the distributions are *very* extreme.

**Revisions:**

* None for now?

### `regression-variation`:

**Description:** This app allows the user to explore how sampling leads to natural variation in regression statistics (correlation and regression coefficients).  The background plot is of an entire population of data, and as you click "get sample" button, it highlights a random sample of the population and fits a regression line.  Subsequent tabs allow the user to see an updating table with the correlation coefficient, and then also the regression coefficient estimates.

**Purpose:** The goal is give a visual sense of sampling variation that arises during regression analysis.  This should reinforce the need for confidence interval estimates for the correlation coefficient, as well as the regression coefficients.

**Revisions:**

* allow for sample size to change
* adjust alpha for population data, make background white

**Ideas:**

* None for now.

***



# Next!

## Sampling from population demonstration apps


### `bias-sample-perc`:

**Description:**

* D

**Purpose:** The goal is 

**Revisions:**

* We could 


**Ideas:**

***

***



## Sampling distributions of statistics apps


### `central-limit-theorem`:

**Description:** This app allows viewers to build a sampling distribution for the sample mean after choosing from a variety of different population "shapes" (Normal, Uniform, Left and Right Skew, and Bimodal).  The user selects a population shape, then he or she can adjust the desired sample size. Using "get one" or "get 100" buttons, the user can systematically sample from the population, compute a mean, and add it to the histogram below, hence building a sampling distribution via simulation. A final slider allows the user to adjust the bin-size of the sampling distribution, for viewing convenience.

* With $n=1$, the user can see that a sampling distribution is essentially the same as the population itself.
* As the user adjusts $n$, they can see that the sampling distribution, *regardless of the population shape*, trends toward normal.
* Moverover:
    * By looking at the vertical lines (which represent the means of the histogram data), one can see the mean of sample means tends to be the population mean.
    * The sample size increasing has the effect of decreasing the variation in the sample means histogram.

This is all a nice visual way to understand the central limit theorem.

**Purpose:** The goal is to provide a visual for the user to understand the Central Limit Theorem.

**Revisions:**

* NA for now.

### `difference-in-means-sampdist`:

**Description:** This app has two tabs that both give the user a sense of the sampling distributions at play in a comparison of means between two populations.

* **Tab 1**: The user can change the population mean of either of two populations. They can also adjust the common sample size taken from each population before computing the sample means. The plot in the upper right shows the population distributions as histograms. The plot in the lower right shows the sampling distributions of sample means ***for each population***.  One can toggle a checkbox to switch to density plots, if that's preferred.

* **Tab 2**: Once again the user can change the population mean of either of two populations and adjust the common sample size taken from each population before computing the sample means. 
    * The user can then build sampling distribution for ***the difference in sample means*** for the two populations by using a "get one" or "get 100" button.
    * As in the previous tab, the plot in the upper right shows the population distributions as histograms. 
    * *However,* the plot in the lower right shows the sampling distributions of ***the difference in sample means***.  One can toggle a checkbox to switch to density plots, if that's preferred.

**Purpose:** The goal is provide a visual and intuitive understanding of how two-sample means comparison tests work. Specifically,

* **Tab 1**: 

    * The user should observe that when the population means are different, increasing the sample size effectively *separates* the sampling distributions for each population. Hence, with large sample sizes, we can detect even small differences.
    * When the population means are the same, these sampling distributions will always overlap, regardless of the sample size.

* **Tab 2**:

    * The user should observe that when the population means are different, the distribution of the *difference in means* stays away from zero. Moerover, increasing the sample size means more of these "differences in means" avoid zero.
    * When the population means are the same, the sampling distribution of the difference in means is centered at zero, with some variation to the left and right. While increasing the sample size affects the variation, the distribution is still centered at zero.

**Revisions:**

* Should we fix the $x$-axis for the sampling distribution plot of Tab 1 to be the same as the population plot?  This might make the distributions hard to see.

### `sample-percentages-sampdist`:

This app has two tabs that both give the user a sense of the sampling distributions for *sample percentages* ($\hat p$).

* **Tab 1**: The user can change the population percentage the population, and the plot on the top left will adjust the mixture of red and blue dots to display that change. A black line indicates the population proportion. The user can also adjust the sample size taken from the population before computing the sample percentages. The plot in the lower right shows the sampling distribution of sample percentages. 
    * Using "get one" or "get 100" buttons, we can draw a sample from the population (highlighted in the top plot with black circles) and add the sample percentage(s) to the histogram on the bottom.
    * A slider to adjust the bins for the sampling distribution histogram is provided for viewing convenience.

* **Tab 2**: This is for a quicker exploration, because the a sampling distribution is generated automatically and plotted as the only plot on this tab. The user can adjust the population percentage (and toggle whether to view this as a vertical line), and adjust the sample size used to generate the sampling distribution. Then the histogram of sample percentages automatically updates.

**Purpose:** The goal is provide a visual and intuitive understanding of how the sampling distribution of sample percentages works. Both tabs communicate the same basic ideas, but the second tab releases the user from having to regenerate the sampling distribution each time a change is made.

Important observations include:

* For $np>10$ or $n(1-p)>10$, the sampling distribution generated has a roughly normal shape.
* The mean of the sample percentages (blue line of Tab 1, or reported below the plot in Tab 2) tracks the population percentage.
* Larger sample sizes means less variation in the sample percentages collected. (Reported below the plot in Tab 2 as Standard Error.)
* One small sample sizes, only certain sample percentages are possible, leading to "odd" looking histograms. (Tab 2 is better for this.)
* When sample sizes are small and $p$ close to 0 or 1, the sampling distribution is skewed and not normal. (Tab 2 is better for this.)


**Revisions:**

* NA for now.


## Simulating LLN apps


### `simulations`:

**Description:** This app shows the Law of Large Numbers at play for three different probabilistic experiments:

* A simple coin flip, hoping for heads;
* Flipping three coins, hoping for three heads;
* Rolling a die, hoping to roll a 1.

Each tab allows the user to use a slider (with a play button) to generate a large number of repetitions of the experiment, tracking the relative frequency of the event against repetitions. The plot shows the relative frequency on the $y$-axis, with the number of repetitions on the $x$ axis.  The user can also use the button to randomly generate a new set of simulations, to show that this behavior is not just a fluke.

**Purpose:** Each tab allows the user to explore how the relative frequency of their event approaches the theoretical probability of that event when the number of repetitions gets large.

**Revisions:**

* In the first tab (simple coin flip), we could allow for unfair coins?
* Possibly adjust the viewing window on the last two simulations.