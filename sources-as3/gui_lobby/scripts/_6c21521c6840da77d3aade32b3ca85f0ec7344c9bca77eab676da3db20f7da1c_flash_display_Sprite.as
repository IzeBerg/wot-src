package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _6c21521c6840da77d3aade32b3ca85f0ec7344c9bca77eab676da3db20f7da1c_flash_display_Sprite extends Sprite
   {
       
      
      public function _6c21521c6840da77d3aade32b3ca85f0ec7344c9bca77eab676da3db20f7da1c_flash_display_Sprite()
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
