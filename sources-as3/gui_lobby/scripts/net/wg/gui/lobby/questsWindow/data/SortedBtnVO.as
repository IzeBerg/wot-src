package net.wg.gui.lobby.questsWindow.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SortedBtnVO extends DAAPIDataClass
   {
       
      
      private var _id:String = "";
      
      private var _label:String = "";
      
      private var _iconSource:String = "";
      
      private var _buttonWidth:Number = 0;
      
      private var _toolTip:String = "";
      
      public function SortedBtnVO(param1:Object)
      {
         super(param1);
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function set id(param1:String) : void
      {
         this._id = param1;
      }
      
      public function get label() : String
      {
         return this._label;
      }
      
      public function set label(param1:String) : void
      {
         this._label = param1;
      }
      
      public function get iconSource() : String
      {
         return this._iconSource;
      }
      
      public function set iconSource(param1:String) : void
      {
         this._iconSource = param1;
      }
      
      public function get buttonWidth() : Number
      {
         return this._buttonWidth;
      }
      
      public function set buttonWidth(param1:Number) : void
      {
         this._buttonWidth = param1;
      }
      
      public function get toolTip() : String
      {
         return this._toolTip;
      }
      
      public function set toolTip(param1:String) : void
      {
         this._toolTip = param1;
      }
   }
}
