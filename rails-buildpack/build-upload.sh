
for value in 2.6.5-stretch 2.7 2.7.3
do
    echo Doing $value...
    pushd $value
      docker build -t rails-buildpack .
      docker tag rails-buildpack:latest 822761295011.dkr.ecr.ap-northeast-1.amazonaws.com/rails-buildpack:$value
      docker push 822761295011.dkr.ecr.ap-northeast-1.amazonaws.com/rails-buildpack:$value
    popd
done
