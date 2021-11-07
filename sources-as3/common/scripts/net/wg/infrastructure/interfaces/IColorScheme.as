package net.wg.infrastructure.interfaces
{
   import flash.filters.BitmapFilter;
   import flash.geom.ColorTransform;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IColorScheme extends IDisposable
   {
       
      
      function get schemeName() : String;
      
      function get aliasColor() : String;
      
      function get rgb() : Number;
      
      function get colorTransform() : ColorTransform;
      
      function get adjustOffset() : BitmapFilter;
   }
}
