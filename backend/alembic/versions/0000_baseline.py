"""
Create empty baseline migration (no tables defined in models)
"""
from alembic import op
import sqlalchemy as sa

# revision identifiers, used by Alembic.
revision = '0000_baseline'
down_revision = None
branch_labels = None
depend_on = None


def upgrade():
    # Baseline migration — no schema changes (models may be added later)
    pass


def downgrade():
    pass
