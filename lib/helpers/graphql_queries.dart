import 'graphql_fragments.dart';

class GraphQlQuery {

  static String getHomepage(){
    return """
      query homepage {
        homepage {
          home_banners{
            cover_image
            link
          }
          job_featured_lists{
            name{
              locale
              value
            }
            data
            jobs {
              _id
              job_name
              company{
                name
              }
            }
          }
          job_recommended_list {
            name{
              locale
              value
            }
            data
            jobs {
              _id
              job_name
              company{
                name
              }
            }
          }
        }
      }
    """;
  }
  static String getJob() {
    return """
    ${GraphQlFragment.jobFields}
    
    query job(\$ids: [ID]) {
      get_jobs(_id: \$ids){
      ...jobFields
      }
    }
    """;
  }

  static String getAllJobs() {
    return """
    ${GraphQlFragment.jobFields}

    query job (\$limit: Int){
      job_search (limit: \$limit){
        total
        result{
          ...jobFields
        }
      }
    }
  """;
  }

  static String updateBookmark() {
    return """
          mutation update_bookmark(
            \$action: BookmarkAction!, 
            \$job_id: ID!) {
                  update_bookmark (
                    action: \$action
                    job_id: \$job_id
                  ) {
                    total
                    bookmarks {
                      _created_at
                    }
                  }
                }
    """;
  }

  static String getBookmarks() {
    return """

      query SavedJob(\$limit: Int){
        saved_jobs(limit:\$limit) {
          total
          bookmarks {
            job {
               _id
              _created_at
              job_name
                start_date
                end_date
              address{
                address
                formatted_address
              }
              company  {
                name
                about
              }
              job_types {
                category
                name
              }
              to_monthly_rate
              to_hourly_rate
            
              employment
              employment_type {
                name
              }
            }
          }
        }
      }
    """;
  }

  static String SearchWithParams() {
    return """
      ${GraphQlFragment.jobFields}

      query SearchWithParams(\$limit: Int, \$monthly_rate: [Float], \$term: String) {
        job_search(limit: \$limit, monthly_rate: \$monthly_rate, term: \$term) {
          total
          result {
            ...jobFields
          }
        }
      }
    """;
  }

  static String getPortfolio() {
    return '''
      ${GraphQlFragment.portfolioFields}

      query Portfolio {
        portfolio {
          ...portfolioFields
        }
      }
    ''';
  }

  static String getApplications() {
    return '''
      ${GraphQlFragment.jobFields}
      ${GraphQlFragment.applicationFields}

      query getApplications(\$limit: Int, \$offset: Int, \$status: ApplicationStatus, \$application_ids: [ID]) {
        get_applications(limit:\$limit, offset:\$offset, status:\$status, application_ids: \$application_ids) {
          total
           applications {
            ...applicationFields
          }
        }
      }
    ''';
  }

  static String applyJob() {
    return '''
      ${GraphQlFragment.jobFields}

      mutation apply_job(
        \$address_ids: [ID], 
        \$job_id: ID!) 
        {
          apply_job (
            address_ids: \$address_ids
            job_id: \$job_id
          ) {
            _id
            address {
              _id
              address
              district_id
              district_name
              district_description
              district_short_code
              formatted_address
              lat
              lng
            }
            applied_at
            contact_viewed_at
            hired_at
            history {
              _created_at
              data
              event
            }
            is_contact_viewed
            is_hired
            is_invalid
            is_hired
            is_reviewed
            rejected_at
            reviewed_at
            job {
              ...jobFields 
            }
          }
        }
          ''';
  }
}
