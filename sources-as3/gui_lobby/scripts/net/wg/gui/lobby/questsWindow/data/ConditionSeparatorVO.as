package net.wg.gui.lobby.questsWindow.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ConditionSeparatorVO extends DAAPIDataClass
   {
       
      
      private var _text:String = "";
      
      private var _linkage:String = "ConditionSeparator_UI";
      
      private var _needAlign:Boolean = false;
      
      public function ConditionSeparatorVO(param1:Object)
      {
         super(param1);
      }
      
      public function get text() : String
      {
         return this._text;
      }
      
      public function set text(param1:String) : void
      {
         this._text = param1;
      }
      
      public function get needAlign() : Boolean
      {
         return this._needAlign;
      }
      
      public function set needAlign(param1:Boolean) : void
      {
         this._needAlign = param1;
      }
      
      public function get linkage() : String
      {
         return this._linkage;
      }
      
      public function set linkage(param1:String) : void
      {
         this._linkage = param1;
      }
   }
}
