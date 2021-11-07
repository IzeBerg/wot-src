package net.wg.infrastructure.managers
{
   import flash.events.IEventDispatcher;
   import flash.geom.ColorTransform;
   import net.wg.infrastructure.base.meta.IColorSchemeManagerMeta;
   import net.wg.infrastructure.interfaces.IColorScheme;
   
   public interface IColorSchemeManager extends IColorSchemeManagerMeta, IEventDispatcher
   {
       
      
      function getScheme(param1:String) : IColorScheme;
      
      function getAliasColor(param1:String) : String;
      
      function getRGB(param1:String) : Number;
      
      function getTransform(param1:String) : ColorTransform;
   }
}
