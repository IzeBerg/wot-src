package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _9295047a0a29663ffccf4158656646b4af5928944562d672552083310ebd967f_flash_display_Sprite extends Sprite
   {
       
      
      public function _9295047a0a29663ffccf4158656646b4af5928944562d672552083310ebd967f_flash_display_Sprite()
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
