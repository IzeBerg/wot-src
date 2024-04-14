package net.wg.gui.lobby.hangar.mapBox
{
   import flash.text.TextField;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.hangar.mapBox.data.MapBoxItemVO;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.ListItemRenderer;
   
   public class MapBoxItemRenderer extends ListItemRenderer
   {
      
      private static const COMPLETED_LABEL:String = "completed";
      
      private static const UNCOMPLETED_LABEL:String = "uncompleted";
       
      
      public var countTf:TextField = null;
      
      public var iconLoader:UILoaderAlt = null;
      
      private var _rendererData:MapBoxItemVO = null;
      
      public function MapBoxItemRenderer()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         if(param1 == null)
         {
            return;
         }
         super.setData(param1);
         this._rendererData = MapBoxItemVO(param1);
         this.iconLoader.source = param1.icon;
         invalidateData();
      }
      
      override protected function draw() : void
      {
         if(this._rendererData && isInvalid(InvalidationType.DATA))
         {
            gotoAndStop(!!this._rendererData.isCompleted ? COMPLETED_LABEL : UNCOMPLETED_LABEL);
            this.countTf.htmlText = this._rendererData.count;
         }
      }
      
      override protected function onDispose() : void
      {
         this.countTf = null;
         this.iconLoader.dispose();
         this.iconLoader = null;
         this._rendererData = null;
         super.onDispose();
      }
   }
}
