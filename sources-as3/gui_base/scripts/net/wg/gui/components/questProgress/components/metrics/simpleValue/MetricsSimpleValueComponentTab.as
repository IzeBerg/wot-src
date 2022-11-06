package net.wg.gui.components.questProgress.components.metrics.simpleValue
{
   import flash.text.TextField;
   import net.wg.gui.components.questProgress.data.metrics.QPMetricsSimpleValueVO;
   import net.wg.utils.ICommons;
   
   public class MetricsSimpleValueComponentTab extends MetricsSimpleValueComponentBase
   {
      
      private static const VALUE_GAP:int = 0;
       
      
      public var titleTf:TextField = null;
      
      private var _commons:ICommons;
      
      public function MetricsSimpleValueComponentTab()
      {
         this._commons = App.utils.commons;
         super();
      }
      
      override protected function onDispose() : void
      {
         this.titleTf = null;
         this._commons = null;
         super.onDispose();
      }
      
      override protected function doInit(param1:QPMetricsSimpleValueVO) : void
      {
         super.doInit(param1);
         this.titleTf.text = param1.title;
         this._commons.updateTextFieldSize(this.titleTf,true,false);
      }
      
      override protected function updateValue(param1:String) : void
      {
         super.updateValue(param1);
         this._commons.updateTextFieldSize(valueTf,true,false);
      }
      
      override protected function doLayout() : void
      {
         valueTf.x = this.titleTf.x + this.titleTf.width + VALUE_GAP;
         componentWidth = valueTf.x + valueTf.width;
         super.doLayout();
      }
   }
}
