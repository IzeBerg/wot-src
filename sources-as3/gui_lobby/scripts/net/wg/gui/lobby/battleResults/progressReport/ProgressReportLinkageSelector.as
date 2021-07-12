package net.wg.gui.lobby.battleResults.progressReport
{
   import net.wg.data.constants.Linkages;
   import net.wg.gui.lobby.questsWindow.ISubtaskListLinkageSelector;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ProgressReportLinkageSelector implements ISubtaskListLinkageSelector, IDisposable
   {
      
      private static const PERSONAL_QUEST_TYPE:int = 8;
       
      
      private var _unlocksCount:int = -1;
      
      private var _unlocksIndex:int = -1;
      
      public function ProgressReportLinkageSelector()
      {
         super();
      }
      
      public function dispose() : void
      {
      }
      
      public function getSpecialLinkage(param1:Object, param2:int) : String
      {
         if(this._unlocksCount && param2 >= this._unlocksIndex && param2 < this._unlocksCount)
         {
            return Linkages.UNLOCK_PROGRESS_LINK;
         }
         if(param1.hasOwnProperty("questType") && param1.questType == PERSONAL_QUEST_TYPE)
         {
            return Linkages.PERSONAL_QUEST_LINK;
         }
         if(param1.hasOwnProperty("dogTagType"))
         {
            return Linkages.UNLOCK_DOG_TAG;
         }
         if(param1.hasOwnProperty("linkage"))
         {
            return param1.linkage;
         }
         return null;
      }
      
      public function setUnlocksCount(param1:int, param2:int) : void
      {
         this._unlocksIndex = param1;
         this._unlocksCount = param2;
      }
   }
}
