package net.wg.gui.battle.views.epicInGameRank.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class EpicInGameRankVO extends DAAPIDataClass
   {
       
      
      public var rank:int = 0;
      
      public var isMaxRank:Boolean = false;
      
      public var previousProgress:Number = 0;
      
      public var newProgress:Number = 0;
      
      public var rankText:String = "";
      
      public function EpicInGameRankVO(param1:Object)
      {
         super(param1);
      }
   }
}
