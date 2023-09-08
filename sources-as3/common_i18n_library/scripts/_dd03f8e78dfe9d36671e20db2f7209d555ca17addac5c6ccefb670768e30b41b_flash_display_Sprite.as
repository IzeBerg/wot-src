package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _dd03f8e78dfe9d36671e20db2f7209d555ca17addac5c6ccefb670768e30b41b_flash_display_Sprite extends Sprite
   {
       
      
      public function _dd03f8e78dfe9d36671e20db2f7209d555ca17addac5c6ccefb670768e30b41b_flash_display_Sprite()
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
