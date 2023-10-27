package net.wg.gui.lobby.profile.components.chart.layout
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IChartLayout extends IDisposable
   {
       
      
      function set gap(param1:Number) : void;
      
      function get gap() : Number;
      
      function set paddingRight(param1:Number) : void;
      
      function get paddingRight() : Number;
      
      function set paddingLeft(param1:Number) : void;
      
      function get paddingLeft() : Number;
      
      function set paddingTop(param1:Number) : void;
      
      function get paddingTop() : Number;
      
      function set paddingBottom(param1:Number) : void;
      
      function get paddingBottom() : Number;
      
      function layout(param1:uint, param2:Object) : void;
   }
}
