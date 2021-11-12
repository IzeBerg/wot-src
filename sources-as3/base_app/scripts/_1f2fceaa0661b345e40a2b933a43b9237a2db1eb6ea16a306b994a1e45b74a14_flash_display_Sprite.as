package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _1f2fceaa0661b345e40a2b933a43b9237a2db1eb6ea16a306b994a1e45b74a14_flash_display_Sprite extends Sprite
   {
       
      
      public function _1f2fceaa0661b345e40a2b933a43b9237a2db1eb6ea16a306b994a1e45b74a14_flash_display_Sprite()
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
