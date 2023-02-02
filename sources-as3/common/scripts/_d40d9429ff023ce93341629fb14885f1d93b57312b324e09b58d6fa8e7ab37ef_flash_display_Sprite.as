package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _d40d9429ff023ce93341629fb14885f1d93b57312b324e09b58d6fa8e7ab37ef_flash_display_Sprite extends Sprite
   {
       
      
      public function _d40d9429ff023ce93341629fb14885f1d93b57312b324e09b58d6fa8e7ab37ef_flash_display_Sprite()
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
