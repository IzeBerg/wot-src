package net.wg.gui.components.tooltips.VO
{
   public class ToolTipBuySkillVO extends ToolTipSkillVO
   {
       
      
      private var _header:String = "";
      
      private var _count:Number = -1;
      
      public function ToolTipBuySkillVO(param1:Object)
      {
         super(param1);
      }
      
      public function get header() : String
      {
         return this._header;
      }
      
      public function set header(param1:String) : void
      {
         this._header = param1;
      }
      
      public function get count() : Number
      {
         return this._count;
      }
      
      public function set count(param1:Number) : void
      {
         this._count = param1;
      }
   }
}
