package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _873007610c665c71e1ecf0c8e6ced5890287c8f69610e01907b7d3a9538cb32d_flash_display_Sprite extends Sprite
   {
       
      
      public function _873007610c665c71e1ecf0c8e6ced5890287c8f69610e01907b7d3a9538cb32d_flash_display_Sprite()
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
