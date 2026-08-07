use ../tests/fake-gh
use ./release

>> 'GitHub' {
  >> 'release' {
    >> 'creation' {
      fake-gh:apply { |spy|
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
        fake-gh:apply { |spy|
          release:upload-artifacts v7 alpha.txt beta.jpg

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
        fake-gh:apply { |spy|
          release:upload-artifacts &overwrite v7 ro.png sigma.png tau.pdf

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