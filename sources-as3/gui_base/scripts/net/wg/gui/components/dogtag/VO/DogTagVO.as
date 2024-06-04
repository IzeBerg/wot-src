package net.wg.gui.components.dogtag.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class DogTagVO extends DAAPIDataClass
   {
      
      private static const BACKGROUND:String = "background";
      
      private static const ENGRAVING:String = "engraving";
       
      
      public var playerName:String = "";
      
      public var clanTag:String = "";
      
      public var background:ComponentVO = null;
      
      public var engraving:ComponentVO = null;
      
      public var isEngravingMaxLevel:Boolean = false;
      
      public var animationSrc:String = "";
      
      public var bottomPlateSrc:String = "";
      
      public function DogTagVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == BACKGROUND && param2 != null)
         {
            this.background = new ComponentVO(param2);
            return false;
         }
         if(param1 == ENGRAVING && param2 != null)
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
