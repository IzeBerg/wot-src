package net.wg.gui.battle.views.postmortemPanel
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IVehiclePanel extends IDisposable
   {
       
      
      function setVehicleData(param1:String, param2:String, param3:String, param4:String, param5:String) : void;
      
      function set visible(param1:Boolean) : void;
      
      function set y(param1:Number) : void;
      
      function get y() : Number;
      
      function set x(param1:Number) : void;
      
      function get width() : Number;
      
      function get x() : Number;
      
      function get height() : Number;
      
      function set alpha(param1:Number) : void;
   }
}
