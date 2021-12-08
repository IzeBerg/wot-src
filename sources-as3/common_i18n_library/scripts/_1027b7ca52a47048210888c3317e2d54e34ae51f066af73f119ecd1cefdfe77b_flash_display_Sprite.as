package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _1027b7ca52a47048210888c3317e2d54e34ae51f066af73f119ecd1cefdfe77b_flash_display_Sprite extends Sprite
   {
       
      
      public function _1027b7ca52a47048210888c3317e2d54e34ae51f066af73f119ecd1cefdfe77b_flash_display_Sprite()
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
