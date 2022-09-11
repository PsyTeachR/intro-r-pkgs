#' APA text for Independent-Samples T-Test
#'
#' Create APA-formatted text for the results of an independent-samples t-test in the following format:
#'
#' Compared to the {n_A} participants in {group_a} (M = {mean_A}, SD = {sd_A}), the {n_B} participants in {group_b} (M = {mean_B}, SD = {sd_B}) had {is_sig}significantly {direction} values, t({df}) = {t_value}, p = {p_value}.
#'
#' @param a A vector (e.g., the values in the control condition).
#' @param b A vector (e.g., the values in the experimental condition).
#' @param group_a The text used to describe group A.
#' @param group_b The text used to describe group B.
#'
#' @return A character string.
#' @export
#'
#' @examples
#' ctl <- rnorm(20, 0, 1)
#' exp <- rnorm(30, 0.8, 1)
#'
#' apa_t_ind(ctl, exp)
#' apa_t_ind(ctl, exp, "group 1", "group 2")
apa_t_ind <- function(a, b,
                      group_a = "the control group",
                      group_b = "the experimental group") {
  t_results <- t.test(b, a)

  template <- "Compared to the {n_A} participants in {group_a} (M = {mean_A}, SD = {sd_A}), the {n_B} participants in {group_b} (M = {mean_B}, SD = {sd_B}) had {is_sig}significantly {direction} values, t({df}) = {t_value}, p = {p_value}."

  glue::glue(template,
             n_A     = length(a),
             n_B     = length(b),
             mean_A  = mean(a) |> round(1),
             sd_A    = sd(a) |> round(1),
             mean_B  = mean(b) |> round(1),
             sd_B    = sd(b) |> round(1),
             is_sig  = ifelse(t_results$p.value < .05, "", "non-"),
             direction = ifelse(mean(b) > mean(a),
                                "larger", "smaller"),
             df      = t_results$parameter |> round(1),
             t_value = t_results$statistic |> round(2),
             p_value = t_results$p.value |> round(3)
  )
}
