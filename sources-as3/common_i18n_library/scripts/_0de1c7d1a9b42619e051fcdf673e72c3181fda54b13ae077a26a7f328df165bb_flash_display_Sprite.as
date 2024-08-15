package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _0de1c7d1a9b42619e051fcdf673e72c3181fda54b13ae077a26a7f328df165bb_flash_display_Sprite extends Sprite
   {
       
      
      public function _0de1c7d1a9b42619e051fcdf673e72c3181fda54b13ae077a26a7f328df165bb_flash_display_Sprite()
      {
         super();
      }
      
      public function allowDomainInRSL(... rest) : void
      {
         Security.allowDomain.apply(null,rest);
      }
      
      public function allowInsecureDomainInRSL(... rest) : void
      {
         Security.allowInsecureDomain.apply(null,rest);
      }
   }
}
