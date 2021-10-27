

import 'graphql_fragments.dart';

class GraphQlQuery {
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
}
