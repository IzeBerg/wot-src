package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _9bcaf3bbed14d18c01fbcd437da4919e25ff2ad520d045d5d2d99f1a11be17a5_flash_display_Sprite extends Sprite
   {
       
      
      public function _9bcaf3bbed14d18c01fbcd437da4919e25ff2ad520d045d5d2d99f1a11be17a5_flash_display_Sprite()
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
