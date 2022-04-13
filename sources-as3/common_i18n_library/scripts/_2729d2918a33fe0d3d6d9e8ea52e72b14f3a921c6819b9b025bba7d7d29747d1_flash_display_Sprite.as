package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _2729d2918a33fe0d3d6d9e8ea52e72b14f3a921c6819b9b025bba7d7d29747d1_flash_display_Sprite extends Sprite
   {
       
      
      public function _2729d2918a33fe0d3d6d9e8ea52e72b14f3a921c6819b9b025bba7d7d29747d1_flash_display_Sprite()
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
