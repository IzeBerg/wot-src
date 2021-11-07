package net.wg.gui.components.dogtag.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class DogTagVO extends DAAPIDataClass
   {
       
      
      public var playerName:String = "";
      
      public var clanTag:String = "";
      
      public var background:ComponentVO = null;
      
      public var engraving:ComponentVO = null;
      
      public var hasData:Boolean = false;
      
      public var isEngravingMaxLevel:Boolean = false;
      
      private const PLAYER_NAME:String = "playerName";
      
      private const CLAN_TAG:String = "clanTag";
      
      private const BACKGROUND:String = "background";
      
      private const ENGRAVING:String = "engraving";
      
      public function DogTagVO(param1:Object)
      {
         super(param1);
         this.hasData = param1 != null;
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == this.BACKGROUND && param2 != null)
         {
            this.background = new ComponentVO(param2);
            return false;
         }
         if(param1 == this.ENGRAVING && param2 != null)
         {
            this.engraving = new ComponentVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.background != null)
         {
            this.background.dispose();
            this.background = null;
         }
         if(this.engraving != null)
         {
            this.engraving.dispose();
            this.engraving = null;
         }
         super.onDispose();
      }
   }
}
