package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _d9c2eee39d3f05fa32609e2f7db398857f07b783b9926167d5cae51a6fd38345_flash_display_Sprite extends Sprite
   {
       
      
      public function _d9c2eee39d3f05fa32609e2f7db398857f07b783b9926167d5cae51a6fd38345_flash_display_Sprite()
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
