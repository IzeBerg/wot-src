package net.wg.data.constants
{
   public class KeyProps
   {
      
      public static const KEY_NONE:Number = 777;
       
      
      private var _keyCommand:String;
      
      private var _keyName:String;
      
      public function KeyProps(param1:String = "", param2:String = "")
      {
         super();
         this.keyCommand = param1;
         this.keyName = param2;
      }
      
      public function set keyCommand(param1:String) : void
      {
         this._keyCommand = param1;
      }
      
      public function get keyCommand() : String
      {
         return this._keyCommand;
      }
      
      public function set keyName(param1:String) : void
      {
         this._keyName = param1;
      }
      
      public function get keyName() : String
      {
         return this._keyName;
      }
   }
}
