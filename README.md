# docker_transmission

## 运行

需要在挂载目录里创建.watch和downloads文件夹

```
docker  run -d -v /${filepath}:/data/downloads -p 9091:9091 unwenliu/transmission:latest
```
