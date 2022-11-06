package net.wg.infrastructure.managers.impl
{
   import flash.geom.ColorTransform;
   import flash.utils.Dictionary;
   import net.wg.data.constants.Linkages;
   import net.wg.infrastructure.base.meta.impl.ColorSchemeManagerMeta;
   import net.wg.infrastructure.interfaces.IColorScheme;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   
   public class ColorSchemeManager extends ColorSchemeManagerMeta implements IColorSchemeManager
   {
       
      
      private var _cache:Dictionary;
      
      public function ColorSchemeManager()
      {
         this._cache = new Dictionary();
         super();
      }
      
      public function getScheme(param1:String) : IColorScheme
      {
         var _loc2_:Class = null;
         var _loc3_:Object = null;
         if(param1 in this._cache)
         {
            return this._cache[param1];
         }
         _loc2_ = App.utils.classFactory.getClass(Linkages.CLR_CSS);
         _loc3_ = new _loc2_(getColorSchemeS(param1));
         this._cache[param1] = _loc3_;
         return _loc3_ as IColorScheme;
      }
      
      public function getAliasColor(param1:String) : String
      {
         return this.getScheme(param1).aliasColor;
      }
      
      public function getRGB(param1:String) : Number
      {
         return this.getScheme(param1).rgb;
      }
      
      public function getTransform(param1:String) : ColorTransform
      {
         return this.getScheme(param1).colorTransform;
      }
      
      public function as_update() : void
      {
         this._cache = new Dictionary();
      }
   }
}
