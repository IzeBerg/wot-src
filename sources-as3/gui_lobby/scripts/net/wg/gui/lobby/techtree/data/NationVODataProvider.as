package net.wg.gui.lobby.techtree.data
{
   import net.wg.data.constants.generated.NODE_STATE_FLAGS;
   import net.wg.gui.lobby.techtree.data.vo.NTDisplayInfo;
   import net.wg.gui.lobby.techtree.data.vo.NationDisplaySettings;
   import net.wg.gui.lobby.techtree.data.vo.NationGridDisplaySettings;
   import net.wg.gui.lobby.techtree.data.vo.NodeData;
   import net.wg.gui.lobby.techtree.interfaces.INationTreeDataProvider;
   import net.wg.utils.ILocale;
   
   public class NationVODataProvider extends AbstractDataProvider implements INationTreeDataProvider
   {
      
      private static const PROPERTY_SCROLL_INDEX:String = "scrollIndex";
      
      private static const PROPERTY_DISPLAY_SETTINGS:String = "displaySettings";
      
      private static const PROPERTY_GRID_SETTINGS:String = "gridSettings";
      
      private static const PROPERTY_PREMIUM_GRID_SETTINGS:String = "premiumSettings";
      
      private static const MAX_LEVELS:int = 11;
       
      
      protected var scrollIndex:Number = 0;
      
      protected var displaySettings:NationDisplaySettings;
      
      protected var premiumNodeIndx:Vector.<int> = null;
      
      protected var premiumLevelInfo:Vector.<NationLevelInfoVO> = null;
      
      protected var commonGridSettings:NationGridDisplaySettings;
      
      protected var premiumGridSettings:NationGridDisplaySettings;
      
      public function NationVODataProvider()
      {
         this.displaySettings = new NationDisplaySettings();
         this.commonGridSettings = new NationGridDisplaySettings();
         this.premiumGridSettings = new NationGridDisplaySettings();
         super();
      }
      
      override public function cleanUp() : void
      {
         super.cleanUp();
         if(this.commonGridSettings != null)
         {
            this.commonGridSettings.cleanUp();
         }
         if(this.premiumGridSettings != null)
         {
            this.premiumGridSettings.cleanUp();
         }
         this.disposeAdditionalInfo();
         this.premiumNodeIndx = new Vector.<int>();
         this.premiumLevelInfo = new Vector.<NationLevelInfoVO>(MAX_LEVELS);
         var _loc1_:int = 0;
         while(_loc1_ < MAX_LEVELS)
         {
            this.premiumLevelInfo[_loc1_] = new NationLevelInfoVO(_loc1_ + 1);
            _loc1_++;
         }
      }
      
      override public function isPremiumItem(param1:Number) : Boolean
      {
         return this.premiumNodeIndx.indexOf(param1) > -1;
      }
      
      override public function parse(param1:Object) : void
      {
         var _loc5_:NodeData = null;
         this.cleanUp();
         NodeData.setDisplayInfoClass(NTDisplayInfo);
         var _loc2_:Array = param1.nodes;
         var _loc3_:ILocale = App.utils.locale;
         if(param1.hasOwnProperty(PROPERTY_SCROLL_INDEX))
         {
            this.scrollIndex = param1.scrollIndex;
         }
         if(param1.hasOwnProperty(PROPERTY_DISPLAY_SETTINGS))
         {
            this.displaySettings.fromObject(param1.displaySettings,_loc3_);
         }
         if(param1.hasOwnProperty(PROPERTY_PREMIUM_GRID_SETTINGS))
         {
            this.premiumGridSettings.fromObject(param1.premiumSettings,_loc3_);
         }
         if(param1.hasOwnProperty(PROPERTY_GRID_SETTINGS))
         {
            this.commonGridSettings.fromObject(param1.gridSettings,_loc3_);
         }
         var _loc4_:Number = _loc2_.length;
         var _loc6_:Number = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = new NodeData();
            _loc5_.fromObject(_loc2_[_loc6_],_loc3_);
            nodeIdxCache[_loc5_.id] = nodeData.length;
            nodeData.push(_loc5_);
            if((_loc5_.state & NODE_STATE_FLAGS.PREMIUM) > 0)
            {
               this.premiumLevelInfo[_loc5_.level - 1].addItem((_loc5_.displayInfo as NTDisplayInfo).column);
               this.premiumNodeIndx.push(_loc6_);
            }
            _loc6_++;
         }
      }
      
      override public function setItemField(param1:String, param2:Number, param3:Object) : Boolean
      {
         var _loc4_:Boolean = super.setItemField(param1,param2,param3);
         if(!_loc4_)
         {
            switch(param1)
            {
               case NodeData.VEH_COMPARE_TREE_NODE_DATA:
                  _loc4_ = this.setVehCompareTreeNode(param2,param3);
            }
         }
         return _loc4_;
      }
      
      override protected function onDispose() : void
      {
         if(this.displaySettings != null)
         {
            this.displaySettings.dispose();
            this.displaySettings = null;
         }
         this.commonGridSettings.dispose();
         this.commonGridSettings = null;
         this.premiumGridSettings.dispose();
         this.premiumGridSettings = null;
         this.disposeAdditionalInfo();
         super.onDispose();
      }
      
      public function getCommonGridSettings() : NationGridDisplaySettings
      {
         return this.commonGridSettings;
      }
      
      public function getDisplaySettings() : NationDisplaySettings
      {
         return this.displaySettings;
      }
      
      public function getPremiumGridSettings() : NationGridDisplaySettings
      {
         return this.premiumGridSettings;
      }
      
      public function getPremiumLevelInfo() : Vector.<NationLevelInfoVO>
      {
         return this.premiumLevelInfo;
      }
      
      public function getScrollIndex() : Number
      {
         return this.scrollIndex;
      }
      
      private function setVehCompareTreeNode(param1:Number, param2:Object) : Boolean
      {
         var _loc3_:Boolean = false;
         if(param1 < nodeData.length && nodeData[param1] != null)
         {
            nodeData[param1].setVehCompareTreeNode(param2);
            _loc3_ = true;
         }
         return _loc3_;
      }
      
      private function disposeAdditionalInfo() : void
      {
         var _loc1_:NationLevelInfoVO = null;
         if(this.premiumNodeIndx != null)
         {
            this.premiumNodeIndx.splice(0,this.premiumNodeIndx.length);
            this.premiumNodeIndx = null;
         }
         if(this.premiumLevelInfo != null)
         {
            for each(_loc1_ in this.premiumLevelInfo)
            {
               _loc1_.dispose();
            }
            this.premiumLevelInfo.splice(0,this.premiumLevelInfo.length);
            this.premiumLevelInfo = null;
         }
      }
   }
}
