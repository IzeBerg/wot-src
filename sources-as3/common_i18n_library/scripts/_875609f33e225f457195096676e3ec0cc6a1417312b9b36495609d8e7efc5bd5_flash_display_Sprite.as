package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _875609f33e225f457195096676e3ec0cc6a1417312b9b36495609d8e7efc5bd5_flash_display_Sprite extends Sprite
   {
       
      
      public function _875609f33e225f457195096676e3ec0cc6a1417312b9b36495609d8e7efc5bd5_flash_display_Sprite()
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
