package net.wg.gui.battle.views.vehicleMessages.vo
{
   public class VehicleMessageVO
   {
      
      public static const COLOR_RED:uint = 14753553;
      
      public static const COLOR_GREEN:uint = 7653168;
      
      public static const COLOR_YELLOW:uint = 16745752;
      
      public static const COLOR_PURPLE:uint = 8886779;
       
      
      private var _key:String = "";
      
      private var _text:String = "";
      
      private var _color:int = -1;
      
      public function VehicleMessageVO(param1:String, param2:String, param3:int)
      {
         super();
         this.update(param1,param2,param3);
      }
      
      public function get key() : String
      {
         return this._key;
      }
      
      public function get text() : String
      {
         return this._text;
      }
      
      public function get color() : int
      {
         return this._color;
      }
      
      public function update(param1:String, param2:String, param3:int) : void
      {
         this._key = param1;
         this._text = param2;
         this._color = param3;
      }
   }
}
