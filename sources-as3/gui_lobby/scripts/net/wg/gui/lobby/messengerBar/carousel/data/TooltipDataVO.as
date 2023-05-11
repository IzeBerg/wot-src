package net.wg.gui.lobby.messengerBar.carousel.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class TooltipDataVO extends DAAPIDataClass implements IToolTipData
   {
       
      
      private var _tooltipId:String = "";
      
      private var _label:String = "";
      
      public function TooltipDataVO(param1:Object)
      {
         super(param1);
      }
      
      public function get tooltipId() : String
      {
         return this._tooltipId;
      }
      
      public function set tooltipId(param1:String) : void
      {
         this._tooltipId = param1;
      }
      
      public function get label() : String
      {
         return this._label;
      }
      
      public function set label(param1:String) : void
      {
         this._label = param1;
      }
   }
}
