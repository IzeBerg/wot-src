package net.wg.gui.lobby.techtree.data
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.techtree.constants.NodeEntityType;
   import net.wg.gui.lobby.techtree.data.vo.NodeData;
   import net.wg.gui.lobby.techtree.data.vo.ResearchDisplayInfo;
   import net.wg.gui.lobby.techtree.data.vo.UnlockProps;
   import net.wg.gui.lobby.techtree.interfaces.IResearchDataProvider;
   import net.wg.gui.lobby.techtree.math.ADG_ItemLevelsBuilder;
   import net.wg.utils.ILocale;
   
   public class ResearchVODataProvider extends AbstractDataProvider implements IResearchDataProvider
   {
      
      private static const DISPLAY_INFO:String = "displayInfo";
       
      
      protected var topData:Vector.<NodeData>;
      
      protected var topLevelIdxCache:Object;
      
      protected var depthOfPaths:Array;
      
      public function ResearchVODataProvider()
      {
         super();
         this.depthOfPaths = [];
      }
      
      override public function cleanUp() : void
      {
         super.cleanUp();
         clearNodeData(this.topData);
         this.topData = new Vector.<NodeData>();
         this.topLevelIdxCache = {};
         this.depthOfPaths.splice(0,this.depthOfPaths.length);
      }
      
      override public function parse(param1:Object) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:NodeData = null;
         var _loc7_:ResearchDisplayInfo = null;
         this.cleanUp();
         NodeData.setDisplayInfoClass(ResearchDisplayInfo);
         var _loc2_:ILocale = App.utils.locale;
         var _loc3_:Array = param1.nodes;
         var _loc4_:Number = _loc3_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = new NodeData();
            _loc6_.fromObject(_loc3_[_loc5_],_loc2_);
            nodeIdxCache[_loc6_.id] = nodeData.length;
            nodeData.push(_loc6_);
            _loc7_ = _loc6_.displayInfo as ResearchDisplayInfo;
            this.depthOfPaths.push(_loc7_ != null ? _loc7_.getDepthOfPath() : 0);
            _loc5_++;
         }
         _loc3_ = param1.top;
         _loc4_ = _loc3_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = new NodeData();
            _loc6_.fromObject(_loc3_[_loc5_],_loc2_);
            this.topLevelIdxCache[_loc6_.id] = this.topData.length;
            this.topData.push(_loc6_);
            _loc5_++;
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
         clearNodeData(this.topData);
         this.depthOfPaths.splice(0);
         this.depthOfPaths = null;
         this.topLevelIdxCache = null;
         super.onDispose();
      }
      
      public function getDepthOfPath(param1:Number) : Number
      {
         var _loc2_:Number = this.depthOfPaths[param1];
         return !!isNaN(_loc2_) ? Number(0) : Number(_loc2_);
      }
      
      public function getTopLevelAt(param1:Number) : NodeData
      {
         return this.topData[param1];
      }
      
      public function getTopLevelIndexByID(param1:Number) : Number
      {
         return this.topLevelIdxCache[param1] != undefined ? Number(this.topLevelIdxCache[param1]) : Number(-1);
      }
      
      public function populate(param1:ADG_ItemLevelsBuilder) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Object = null;
         var _loc8_:Array = null;
         var _loc9_:ResearchDisplayInfo = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc2_:Array = param1.matrix;
         var _loc3_:Number = nodeData.length;
         var _loc10_:Number = 0;
         while(_loc10_ < _loc3_)
         {
            _loc7_ = nodeData[_loc10_];
            _loc9_ = _loc7_.displayInfo as ResearchDisplayInfo;
            App.utils.asserter.assertNotNull(_loc9_,DISPLAY_INFO + Errors.CANT_NULL);
            if(_loc9_.level > -1)
            {
               param1.addFixedPath(_loc10_,_loc9_.level);
            }
            _loc6_ = 0;
            _loc8_ = _loc9_.path;
            _loc12_ = _loc8_.length;
            _loc11_ = 0;
            while(_loc11_ < _loc12_)
            {
               _loc5_ = getIndexByID(_loc8_[_loc11_]);
               _loc6_ = Math.max(_loc6_,this.getDepthOfPath(_loc5_));
               _loc11_++;
            }
            _loc11_ = 0;
            while(_loc11_ < _loc12_)
            {
               _loc4_ = _loc8_[_loc11_];
               if(!(isNaN(_loc4_) || _loc4_ == 0))
               {
                  _loc5_ = getIndexByID(_loc4_);
                  if(!isNaN(_loc5_) && this.getDepthOfPath(_loc5_) == _loc6_)
                  {
                     _loc2_[_loc5_][_loc10_] = 1;
                     _loc2_[_loc10_][_loc5_] = -1;
                  }
               }
               _loc11_++;
            }
            _loc10_++;
         }
      }
      
      public function resolveEntityType(param1:NodeData, param2:Boolean = false) : uint
      {
         var _loc4_:ResearchDisplayInfo = null;
         var _loc3_:uint = 0;
         if(param1 != null)
         {
            _loc4_ = param1.displayInfo as ResearchDisplayInfo;
            if(_loc4_ != null)
            {
               if(_loc4_.isDrawVehicle())
               {
                  _loc3_ = !!param2 ? uint(NodeEntityType.TOP_VEHICLE) : uint(NodeEntityType.NEXT_VEHICLE);
               }
               else
               {
                  _loc3_ = NodeEntityType.RESEARCH_ITEM;
               }
            }
         }
         return _loc3_;
      }
      
      public function setTopLevelField(param1:String, param2:Number, param3:Object) : Boolean
      {
         var _loc5_:Array = null;
         var _loc6_:UnlockProps = null;
         var _loc4_:Boolean = false;
         switch(param1)
         {
            case NodeData.UNLOCK_PROPS_FIELD:
               _loc5_ = param3 as Array;
               App.utils.asserter.assertNotNull(_loc5_,Errors.INVALID_TYPE + ARRAY);
               _loc6_ = new UnlockProps();
               _loc6_.fromArray(_loc5_,App.utils.locale);
               _loc4_ = this.setTopLevelUnlockProps(param2,_loc6_);
               break;
            case NodeData.VEH_COMPARE_TREE_NODE_DATA:
               _loc4_ = this.setTopLevelVehCompareTreeNode(param2,param3);
         }
         return _loc4_;
      }
      
      public function setTopLevelState(param1:Number, param2:Number, param3:Number) : Boolean
      {
         return findAndSetState(this.topData,param1,param2,param3);
      }
      
      public function setTopLevelUnlockProps(param1:Number, param2:UnlockProps) : Boolean
      {
         var _loc3_:Boolean = false;
         if(param1 < this.topData.length && this.topData[param1] != null)
         {
            this.topData[param1].unlockProps = param2;
            _loc3_ = true;
         }
         return _loc3_;
      }
      
      public function setTopLevelVehCompareTreeNode(param1:Number, param2:Object) : Boolean
      {
         var _loc3_:Boolean = false;
         if(param1 < this.topData.length && this.topData[param1] != null)
         {
            this.topData[param1].setVehCompareTreeNode(param2);
            _loc3_ = true;
         }
         return _loc3_;
      }
      
      public function setTopLevelXP(param1:Number, param2:Number) : Boolean
      {
         var _loc3_:Boolean = false;
         if(param1 < this.topData.length && this.topData[param1] != null)
         {
            this.topData[param1].earnedXP = param2;
            _loc3_ = true;
         }
         return _loc3_;
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
      
      public function get topLength() : Number
      {
         return this.topData.length;
      }
   }
}
