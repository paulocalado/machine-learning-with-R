
ggplot(mpg,aes(x=displ,y=hwy))+
  geom_point() + coord_cartesian(xlim = c(1,4),ylim = c(15,30))

ggplot(mpg,aes(x=displ,y=hwy))+
  geom_point() + coord_fixed(ratio = 1/3)

ggplot(mpg,aes(x=displ,y=hwy))+
  geom_point()+
  facet_grid(. ~ cyl)

ggplot(mpg,aes(x=displ,y=hwy))+
  geom_point()+
  facet_grid(drv ~ .)

ggplot(mpg, aes(x=displ,y=hwy))+
  geom_point()+
  facet_grid(drv ~cyl)
