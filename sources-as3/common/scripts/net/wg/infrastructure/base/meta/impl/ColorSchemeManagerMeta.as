package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIModule;
   
   public class ColorSchemeManagerMeta extends BaseDAAPIModule
   {
       
      
      public var getColorScheme:Function;
      
      public var getIsColorBlind:Function;
      
      public function ColorSchemeManagerMeta()
      {
         super();
      }
      
      public function getColorSchemeS(param1:String) : Object
      {
         App.utils.asserter.assertNotNull(this.getColorScheme,"getColorScheme" + Errors.CANT_NULL);
         return this.getColorScheme(param1);
      }
      
      public function getIsColorBlindS() : Boolean
      {
         App.utils.asserter.assertNotNull(this.getIsColorBlind,"getIsColorBlind" + Errors.CANT_NULL);
         return this.getIsColorBlind();
      }
   }
}
