package net.wg.gui.components.questProgress.components.metrics.simple
{
   import net.wg.data.constants.generated.QUESTSPROGRESS;
   import net.wg.gui.components.questProgress.QuestProgressAtlasSprite;
   
   public class MetricsSimpleComponentTop extends MetricsSimpleComponentBase
   {
       
      
      public var img:QuestProgressAtlasSprite = null;
      
      public function MetricsSimpleComponentTop()
      {
         super();
      }
      
      override protected function doPrepare() : void
      {
         this.img.isCentralize = true;
         this.img.imageName = QUESTSPROGRESS.QP_DOT;
         super.doPrepare();
      }
      
      override protected function doUpdateState(param1:int) : void
      {
         this.img.visible = !isCompleted;
         super.doUpdateState(param1);
      }
      
      override protected function onDispose() : void
      {
         this.img = null;
         super.onDispose();
      }
   }
}
