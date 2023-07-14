package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _37da3d20576a737ceebd9d45a6f988090850759e3d066dfe27c1265f6d8a98b9_flash_display_Sprite extends Sprite
   {
       
      
      public function _37da3d20576a737ceebd9d45a6f988090850759e3d066dfe27c1265f6d8a98b9_flash_display_Sprite()
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
