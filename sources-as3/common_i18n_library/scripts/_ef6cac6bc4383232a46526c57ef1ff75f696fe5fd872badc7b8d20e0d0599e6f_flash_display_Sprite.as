package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _ef6cac6bc4383232a46526c57ef1ff75f696fe5fd872badc7b8d20e0d0599e6f_flash_display_Sprite extends Sprite
   {
       
      
      public function _ef6cac6bc4383232a46526c57ef1ff75f696fe5fd872badc7b8d20e0d0599e6f_flash_display_Sprite()
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
