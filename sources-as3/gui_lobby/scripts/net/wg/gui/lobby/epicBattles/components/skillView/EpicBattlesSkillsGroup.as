package net.wg.gui.lobby.epicBattles.components.skillView
{
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.common.containers.TiledLayout;
   import net.wg.gui.components.containers.GroupEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class EpicBattlesSkillsGroup extends GroupEx
   {
      
      private static const RENDERERS_GAP:int = 5;
      
      private static const BIG_RENDERERS_GAP:int = 9;
      
      private static const COLUMNS:int = 3;
      
      private static const INVALID_SELECTED_IDX:String = "invalidSelectedIdx";
      
      private static const INVALID_RENDERES_SIZE:String = "invalidRenderersSize";
       
      
      private var _selectedIdx:int = -1;
      
      private var _renderersState:String = "minres";
      
      public function EpicBattlesSkillsGroup()
      {
         super();
         itemRendererLinkage = Linkages.EPIC_BATTLES_SKILL_VIEW_SKILL_TILE_UI;
         var _loc1_:TiledLayout = new TiledLayout(EpicBattlesSkillTile.WIDTH,EpicBattlesSkillTile.HEIGHT,COLUMNS);
         _loc1_.gap = RENDERERS_GAP;
         layout = _loc1_;
      }
      
      override protected function draw() : void
      {
         var _loc1_:EpicBattlesSkillTile = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:TiledLayout = null;
         super.draw();
         if(isInvalid(INVALID_RENDERES_SIZE,INVALID_SELECTED_IDX,InvalidationType.DATA))
         {
            _loc2_ = renderers.length;
            _loc4_ = false;
            if(isInvalid(INVALID_RENDERES_SIZE))
            {
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  _loc1_ = EpicBattlesSkillTile(getRendererAt(_loc3_));
                  _loc1_.state = this._renderersState;
                  _loc3_++;
               }
               if(_loc2_)
               {
                  _loc4_ = true;
               }
            }
            if(isInvalid(INVALID_SELECTED_IDX))
            {
               _loc5_ = getProviderLength();
               if(_loc5_ != _loc2_)
               {
                  return;
               }
               _loc3_ = 0;
               while(_loc3_ < _loc5_)
               {
                  _loc1_ = EpicBattlesSkillTile(getRendererAt(_loc3_));
                  _loc1_.selected = _loc3_ == this._selectedIdx;
                  _loc3_++;
               }
            }
            if(isInvalid(InvalidationType.DATA))
            {
               _loc4_ = true;
            }
            if(_loc4_ && _loc2_)
            {
               _loc6_ = TiledLayout(layout);
               _loc1_ = EpicBattlesSkillTile(getRendererAt(0));
               _loc6_.rendererWidth = _loc1_.width;
               _loc6_.rendererHeight = _loc1_.height;
               _loc6_.gap = this._renderersState == EpicBattlesSkillTile.MIN_RES_STATE ? int(RENDERERS_GAP) : int(BIG_RENDERERS_GAP);
               _loc6_.invokeLayout();
            }
         }
      }
      
      public function setSelectedTile(param1:int) : void
      {
         if(param1 != this._selectedIdx)
         {
            this._selectedIdx = param1;
            invalidate(INVALID_SELECTED_IDX);
         }
      }
      
      public function switchRenderersSize(param1:Boolean) : void
      {
         this._renderersState = !!param1 ? EpicBattlesSkillTile.MIN_RES_STATE : EpicBattlesSkillTile.REG_RES_STATE;
         invalidate(INVALID_RENDERES_SIZE);
      }
      
      override public function get width() : Number
      {
         var _loc1_:TiledLayout = TiledLayout(layout);
         return (_loc1_.rendererWidth + _loc1_.gap) * COLUMNS - _loc1_.gap;
      }
      
      override public function get height() : Number
      {
         var _loc1_:uint = Math.ceil(getProviderLength() / COLUMNS);
         var _loc2_:TiledLayout = TiledLayout(layout);
         return (_loc2_.rendererHeight + _loc2_.gap) * _loc1_ - _loc2_.gap;
      }
   }
}
