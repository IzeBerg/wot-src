package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _40500c0a7fc6879bb8227a9b4bb6eb364de9b5ca2bb5f5097092b88622f21fab_flash_display_Sprite extends Sprite
   {
       
      
      public function _40500c0a7fc6879bb8227a9b4bb6eb364de9b5ca2bb5f5097092b88622f21fab_flash_display_Sprite()
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
