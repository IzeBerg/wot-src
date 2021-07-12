package net.wg.data.managers
{
   import net.wg.infrastructure.interfaces.entity.ICloneable;
   
   public interface ITooltipProps extends ICloneable
   {
       
      
      function get type() : String;
      
      function get x() : Number;
      
      function get y() : Number;
      
      function get minWidth() : Number;
      
      function get drawDelay() : Number;
      
      function get showDelay() : Number;
      
      function get maxWidth() : Number;
      
      function set maxWidth(param1:Number) : void;
   }
}
