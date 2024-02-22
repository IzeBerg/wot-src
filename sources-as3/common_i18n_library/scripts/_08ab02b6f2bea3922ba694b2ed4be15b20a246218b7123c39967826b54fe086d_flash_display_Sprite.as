package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _08ab02b6f2bea3922ba694b2ed4be15b20a246218b7123c39967826b54fe086d_flash_display_Sprite extends Sprite
   {
       
      
      public function _08ab02b6f2bea3922ba694b2ed4be15b20a246218b7123c39967826b54fe086d_flash_display_Sprite()
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
