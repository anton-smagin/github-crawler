# frozen_string_literal: true

class HomeController < ApplicationController # :nodoc:
  def index
    fetch_repositories
  end

  private

  def fetch_repositories
    return (@repositories = []) unless params[:search_term].present?

    client = Octokit::Client.new
    @repositories =
      client
      .search_repositories(params[:search_term])
      .items
      .map { |repo| { name: repo.name, html_url: repo.html_url } }
  end
end
