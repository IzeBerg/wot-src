package net.wg.gui.lobby.training
{
   import net.wg.utils.ICommons;
   import scaleform.clik.controls.ListItemRenderer;
   
   public class MapsListItemRenderer extends ListItemRenderer
   {
      
      private static const MAX_WIDTH:uint = 239;
      
      private static const DOTS:String = "...";
      
      private static const CONDITIONS_INFO_OFFSET_X:uint = 13;
       
      
      public var additionalInfo:AdditionalInfo = null;
      
      private var _commons:ICommons;
      
      public function MapsListItemRenderer()
      {
         this._commons = App.utils.commons;
         super();
      }
      
      override public function setActualSize(param1:Number, param2:Number) : void
      {
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         if(!param1)
         {
            return;
         }
         this.additionalInfo.visible = param1.additionalInfo;
         if(param1.additionalInfo)
         {
            this.additionalInfo.setType(param1.additionalInfo);
         }
      }
      
      override protected function onDispose() : void
      {
         this.additionalInfo.dispose();
         this.additionalInfo = null;
         this._commons = null;
         super.onDispose();
      }
      
      override protected function updateText() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         super.updateText();
         if(textField != null)
         {
            _loc1_ = this.additionalInfo.width;
            _loc2_ = MAX_WIDTH - _loc1_ | 0;
            if(textField.width > _loc2_)
            {
               textField.width = _loc2_;
               this._commons.truncateTextFieldText(textField,textField.text,true,false,DOTS);
            }
            this.additionalInfo.x = textField.textWidth + CONDITIONS_INFO_OFFSET_X | 0;
            if(this.additionalInfo.x > width - _loc1_)
            {
               this.additionalInfo.x = width - _loc1_;
            }
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.additionalInfo.visible = false;
      }
   }
}
