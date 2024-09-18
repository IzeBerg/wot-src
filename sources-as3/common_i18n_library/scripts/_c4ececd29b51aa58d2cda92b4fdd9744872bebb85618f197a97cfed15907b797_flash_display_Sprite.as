package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _c4ececd29b51aa58d2cda92b4fdd9744872bebb85618f197a97cfed15907b797_flash_display_Sprite extends Sprite
   {
       
      
      public function _c4ececd29b51aa58d2cda92b4fdd9744872bebb85618f197a97cfed15907b797_flash_display_Sprite()
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
