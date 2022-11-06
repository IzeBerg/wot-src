package net.wg.gui.components.questProgress.components.metrics.limiter
{
   import flash.text.TextField;
   import net.wg.data.constants.generated.QUESTSPROGRESS;
   import net.wg.gui.components.questProgress.QuestProgressAtlasSprite;
   
   public class MetricsLimiterComponentTop extends MetricsLimiterComponentBase
   {
       
      
      public var warningIco:QuestProgressAtlasSprite = null;
      
      public var valueTf:TextField = null;
      
      public function MetricsLimiterComponentTop()
      {
         super();
      }
      
      override protected function doPrepare() : void
      {
         this.warningIco.isCentralize = true;
         this.warningIco.imageName = QUESTSPROGRESS.WARNING;
         super.doPrepare();
      }
      
      override protected function updateValue(param1:String, param2:Boolean) : void
      {
         super.updateValue(param1,param2);
         this.valueTf.text = param1;
         this.warningIco.visible = param2;
      }
      
      override protected function onDispose() : void
      {
         this.warningIco = null;
         this.valueTf = null;
         super.onDispose();
      }
   }
}
