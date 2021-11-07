package net.wg.gui.components.questProgress.components.metrics.simple
{
   import flash.text.TextField;
   import net.wg.utils.ICommons;
   
   public class MetricsSimpleComponentTab extends MetricsSimpleComponentBase
   {
       
      
      public var inProgressTf:TextField = null;
      
      private var _commons:ICommons;
      
      public function MetricsSimpleComponentTab()
      {
         this._commons = App.utils.commons;
         super();
      }
      
      override protected function doPrepare() : void
      {
         this.inProgressTf.text = QUESTS.METRICS_STATE_INPROGRESS;
         this._commons.updateTextFieldSize(this.inProgressTf,true,false);
         componentWidth = this.inProgressTf.width;
         super.doPrepare();
      }
      
      override protected function onDispose() : void
      {
         this.inProgressTf = null;
         this._commons = null;
         super.onDispose();
      }
   }
}
