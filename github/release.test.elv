use ./release

fn with-test-gh { |block|
  var spy = (command:spy)

  tmp release:-gh~ = $spy[command]

  $block $spy
}

>> 'GitHub' {
  >> 'release' {
    >> 'creation' {
      with-test-gh { |spy|
        release:create-draft v7 'Test title'

        $spy[get-runs] |
          should-be [
            [
              release
              create
              v7
              --draft
              --title
              'Test title'
              --generate-notes
            ]
          ]
      }
    }

    >> 'artifact uploading' {
      >> 'when not overwriting' {
        with-test-gh { |spy|
          release:upload-artifacts [
            &files=[
              alpha.txt
              beta.jpg
            ]
            &release-tag=v7
            &overwrite=$false
          ]

          $spy[get-runs] |
            should-be [
              [
                release
                upload
                v7
                alpha.txt
                beta.jpg
              ]
            ]
        }
      }

      >> 'when overwriting' {
        with-test-gh { |spy|
          release:upload-artifacts [
            &files=[
              ro.png
              sigma.png
              tau.pdf
            ]
            &release-tag=v7
            &overwrite=$true
          ]

          $spy[get-runs] |
            should-be [
              [
                release
                upload
                --clobber
                v7
                ro.png
                sigma.png
                tau.pdf
              ]
            ]
        }
      }
    }
  }
}